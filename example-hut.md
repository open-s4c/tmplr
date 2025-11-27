Say you have this this file with a template block:

    $_begin(AA = [[2;3;4]])
    Mein Hut hat AA Ecken.
    $_end
    EOF

If you run that without any arguments you get:

    % tmplr example
    Mein Hut hat 2 Ecken.
    Mein Hut hat 3 Ecken.
    Mein Hut hat 4 Ecken.

Now, if we want to redefine AA from the command line we use:

    % tmplr -DAA="3;5;7" example
    Mein Hut hat 3 Ecken.
    Mein Hut hat 5 Ecken.
    Mein Hut hat 7 Ecken.

The `-D` flag completely redefine the values of the keyword. That is the
breaking change.

The old behavior can be reached with the `-F` option, standing for *filter*:

    % tmplr -FAA="3;5;7" example
    Mein Hut hat 3 Ecken.

With the filter, only the values in the intersection of file and flag are used
in the template iteration.
