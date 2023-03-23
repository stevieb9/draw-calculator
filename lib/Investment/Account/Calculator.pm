package Investment::Account::Calculator;

use strict;
use warnings;

use Dancer2;
use Data::Dumper;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Investment::Account::Calculator' };
};

post '/render' => sub {
    my $params = from_json(request->body);

    my $balance = $params->{account_balance};
    my $monthly_draw = $params->{monthly_draw};
    my $return_rate = $params->{return_rate};

    my %year_data;

    my $months = 1;
    my $years = 0;

    my $revenue_total = 0;

    while ($balance > 0) {
        $balance -= $monthly_draw;

        my $revenue_year = $balance * ($return_rate / 100);
        my $revenue_month = $revenue_year / 12;

        $revenue_total += $revenue_month;

        $balance += $revenue_month;

        last if $balance < 0;
        last if $years >= 100;
        last if $balance == "inf";

        $year_data{$years}->{balance} = $balance;
        $year_data{$years}->{revenue} += $revenue_month;

        if ($months % 12 == 0 && $months != 0) {
            $years++;
        }

        $months++;
    };

    my $revenue_avg = $years ? $revenue_total / $years : 0;

    my @year_list;

    for (sort { $a <=> $b } keys %year_data) {

#
        $year_data{$_}->{balance} = sprintf '%.2f', $year_data{$_}->{balance};
        $year_data{$_}->{revenue} = sprintf '%.2f', $year_data{$_}->{revenue};
        while ($year_data{$_}->{balance} =~ s/(\d+)(\d\d\d)/$1\,$2/) {};
        while ($year_data{$_}->{revenue} =~ s/(\d+)(\d\d\d)/$1\,$2/) {};
        #
        $year_data{$_}->{balance} = "\$$year_data{$_}->{balance}";
        $year_data{$_}->{revenue} = "\$$year_data{$_}->{revenue}";
#
        push @year_list, $year_data{$_};
    }

    my $results = {
        years               => $years,
        year_data           => \@year_list,
        year_avg_revenue    => $revenue_avg,
    };

    return to_json($results);
};

true;
