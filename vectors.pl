#!/usr/bin/perl -w

# generate vectors.S, the trap/interrupt entry points.
# there has to be one entry point per interrupt number
# since otherwise there's no way to tell the interrupt
# number.

print "/* generated by vectors.pl */\n";
print ".text\n";
print ".globl alltraps\n";
for(my $i = 0; $i < 256; $i++){
    print ".globl vector$i\n";
    print "vector$i:\n";
    if(($i < 8 || $i > 14) && $i != 17){
        print "\tpushl \$0\n";
    }
    print "\tpushl \$$i\n";
    print "\tjmp alltraps\n";
}
print ".data\n";
print ".globl vectors\n";
print "vectors:\n";
for(my $i = 0; $i < 256; $i++){
    print ".long vector$i\n";
}
