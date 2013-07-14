genPush = function(dir, fraction) {
    return S.op("push", {
        "direction": dir,
        "style": "bar-resize:screenSizeX*" + fraction
    });
};

var left = {};
var right = {};

var fractions = ["1/2", "1/3", "2/3"];

for (var f in fractions) {
    var fraction = fractions[f];
    left[fraction] = genPush('left', fraction);
    right[fraction] = genPush('right', fraction);
};

var middle = S.op("move", {
    "x": "screenOriginX+(screenSizeX/6)",
    "y": "screenOriginY",
    "width": "2*screenSizeX/3",
    "height": "screenSizeY"
});

var fullscreen = S.op("move", {
    "x": "screenOriginX",
    "y": "screenOriginY",
    "width": "screenSizeX",
    "height": "screenSizeY"
});

var programmingLayout = S.layout("programming", {
    '_after_': {'operations': [
        S.op("focus", {'app': 'iTerm'}),
        S.op("focus", {'app': 'Emacs'})
    ]},
    'Emacs': { "operations": left["2/3"] },
    'Google Chrome': { "operations": left["2/3"] },
    'iTerm': { "operations": right["1/3"] }
});

S.bind("1:cmd,shift,space", left["1/2"]);
S.bind("2:cmd,shift,space", right["1/2"]);
S.bind("3:cmd,shift,space", left["2/3"]);
S.bind("4:cmd,shift,space", right["1/3"]);
S.bind("5:cmd,shift,space", left["1/3"]);
S.bind("6:cmd,shift,space", right["2/3"]);

S.bind("y:cmd,shift,space", fullscreen);
S.bind("j:cmd,shift,space", middle);
S.bind("p:cmd,shift,space", S.op("layout", {"name": programmingLayout}));
