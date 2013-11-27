# Dynamic Collections in Functional Reactive Programming
This is the follow along code I produced with this blog post.
It describes two possible ways to manage collections of dynamic entities in a
FRP framework.

## To Build:
I recommend using the sandboxes available in cabal 1.10.
To build with cabal sandboxes do the following:

    git clone https://github.com/chanko08/frp-dynamic-collections.git 
    cd frp-dynamic-collections
    cabal sandbox init
    cabal install

Now you can run either of the programs with

    .cabal-sandbox/bin/bullet-collection

or

    .cabal-sandbox/bin/bulletbehavior-collection

