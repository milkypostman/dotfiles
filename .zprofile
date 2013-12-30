#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

[ -x /usr/libexec/java_home ] && export JAVA_HOME="$(/usr/libexec/java_home)"
[ -e $HOME/.ec2 ] && export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
[ -e $HOME/.ec2 ] && export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
[ -e $HOME/.ec2 ] && export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
[ -e $HOME/.ec2 ] && export EC2_URL="https://ec2.us-west-1.amazonaws.com"
