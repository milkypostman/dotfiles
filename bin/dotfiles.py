#!/usr/bin/env python

from __future__ import print_function

from contextlib import contextmanager
from os import path
from subprocess import check_output as cmd
import glob
import logging
import os
import sys
import subprocess
import shutil

log = logging.getLogger('dotfiles')

HOME = os.environ['HOME']
SYMLINKS = (
    ('114', 'Dropbox/Coe/2012f/FYS'),
    ('115', 'Dropbox/Coe/2012f/115'),
    ('325', 'Dropbox/Coe/2012f/325'),
    ('Coe', 'Dropbox/Coe'),
    ('src', 'Dropbox/Development'),
    ('Development', 'Dropbox/Development'),
    )

IGNORE=('.git', '.gitignore')

__path = path.realpath(__file__)
__dir = path.dirname(__path)
__base_dir = path.dirname(__dir)

@contextmanager
def message(msg, end=''):
    print("{0}...".format(msg), end=end)
    yield
    print("done.")

def activate_virtualenv():
    activate_path = path.join(HOME, '.virtualenv', 'default', 'bin', 'activate_this.py')

    if not path.exists(activate_path):
        setup_virtualenv()

    execfile(activate_path, dict(__file__=activate_path))


def setup_virtualenv():
    """
    Setup a default virtual environment
    """

    virtualenv_dir = path.join(HOME, '.virtualenv')

    if not path.exists(virtualenv_dir):
        os.mkdir(virtualenv_dir)

    default_virtualenv_dir = path.join(virtualenv_dir, 'default')

    if path.exists(default_virtualenv_dir):
        # print("Default virtualenv directory already exists: {0}".format(
        #         default_virtualenv_dir))
        return

    create_cmd = ['virtualenv', default_virtualenv_dir]
    try:
        return cmd(create_cmd)
    except:
        log.error("Problem running command: {0}".format(' '.join(create_cmd)))


def install_sh():
    """
    Install and activate the sh module
    """

    install_sh = ['pip', 'install', 'sh']
    return cmd(install_sh)

def listdir(basedir):
    return (path.join(basedir, fn) \
                for fn in os.listdir(basedir) if not fn in IGNORE)

def copy_templates():
    """
    Copy template files.
    """

    for file_path in (fn for fn in listdir(__base_dir) if fn.endswith(".template")):
        file_dir, file_name = path.split(file_path)
        file_name_root, file_name_ext = path.splitext(file_name)

        home_path = path.join(HOME, file_name_root)

        if path.exists(home_path):
            continue

        shutil.copy(file_path, home_path)
        print("{0} -> {1}".format(file_path, home_path))


__symbol = {
    1: '+',
    0: '-',
    -1: 'x',
    }

def symlink(src, dest):
    """
    Link or update link from src to dest.
    """
    if path.islink(dest):
        if path.realpath(dest) != src:
            os.unlink(dest)
        else:
            return 0


    elif path.isfile(dest) or path.isdir(dest):
        return -1

    os.symlink(src, dest)
    return 1


def link_files():
    """
    Link all the files properly.
    """

    for file_path in listdir(__base_dir):
        if file_path.endswith(".template"): continue

        file_dir, file_name = path.split(file_path)
        home_path = path.join(HOME, file_name)

        print("{0} {1}".format(__symbol[symlink(file_path, home_path)], file_name))


def create_symlinks():
    """
    Create custom symlinks.
    """

    for dest, src in SYMLINKS:
        if not src.startswith("/"): src = path.join(HOME, src)
        dest = path.join(HOME, dest)
        symlink(src, dest)
        print("{0} -> {1}".format(src, dest))

def cleanup_old():
    """
    Remove broken symbolic links.
    """

    for fn in listdir(HOME):
        if not path.exists(fn):
            print("broken: {0}".format(fn))



if __name__ == '__main__':
    logging.basicConfig(level=logging.INFO)
    print("Home Directory: {0}".format(HOME))
    print("")

    with message("Activating virtualenv"):
        activate_virtualenv()

    print("")
    print("Linking files...")
    link_files()

    print("")
    print("Copying templates...")
    copy_templates()

    print("")
    print("Setting up custom symlinks...")
    create_symlinks()

    print("")
    print("Removing broken links...")
    cleanup_old()
