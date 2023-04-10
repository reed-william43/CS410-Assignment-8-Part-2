#!/usr/bin/perl

use strict;
use warnings;
use diagnostics;

use feature 'say';
use v5.16;

# Read input filename from command line argument
my $input_filename = "text.txt";

# Read file contents into array of lines
open(my $input_fh, '<', $input_filename) or die "Could not open $input_filename: $!";
chomp(my @lines = <$input_fh>);
close($input_fh);

# Initialize variables for tracking highest average score
my $highest_avg_score = 0;
my $highest_user = '';

# Loop through lines in file
foreach my $line (@lines) {
    my ($name, @scores) = split(':', $line);

    # Calculate average score
    my $num_scores = scalar(@scores);
    my $total_score = 0;
    foreach my $score (@scores) {
        $total_score += $score;
    }
    my $avg_score = $total_score / $num_scores;

    # Update highest average score if necessary
    if ($avg_score > $highest_avg_score) {
        $highest_avg_score = $avg_score;
        $highest_user = $name;
    }
}

# Write output to file
open(my $output_fh, '>', 'highest.txt') or die "Could not open highest.txt for writing: $!";
print $output_fh "$highest_user: $highest_avg_score\n";
close($output_fh);

print "Highest average score: $highest_user - $highest_avg_score\n";
