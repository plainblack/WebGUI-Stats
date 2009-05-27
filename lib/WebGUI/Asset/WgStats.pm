package WebGUI::Asset::WgStats;


use strict;
use Tie::IxHash;
use base ( 'WebGUI::AssetAspect::Installable', 'WebGUI::Asset' );
use WebGUI::Utility;
use WebGUI::AssetCollateral::WgStats;
use WebGUI::AssetCollateral::WgAssetStats;
use JSON;

#-------------------------------------------------------------------
sub definition {
    my $class      = shift;
    my $session    = shift;
    my $definition = shift;
    tie my %properties, 'Tie::IxHash', (
    );
    push @{$definition}, {
        assetName         => 'WebGUI Stats',
        autoGenerateForms => 1,
        tableName         => 'WgStats',
        className         => 'WebGUI::Asset::WgStats',
        properties        => \%properties,
        };
    return $class->SUPER::definition( $session, $definition );
} 

#-------------------------------------------------------------------
sub install {
      my $class     = shift;
      my $session   = shift;
      WebGUI::AssetCollateral::WgStats->crud_createTable($session);
      WebGUI::AssetCollateral::WgAssetStats->crud_createTable($session);
      $class->next::method( $session );
}

#-------------------------------------------------------------------
sub uninstall {
      my $class     = shift;
      my $session   = shift;
      WebGUI::AssetCollateral::WgStats->crud_dropTable($session);
      WebGUI::AssetCollateral::WgAssetStats->crud_dropTable($session);
      $class->next::method( $session );
}


#-------------------------------------------------------------------
sub view {
    my $self = shift;
    my $db = $self->session->db;
    my $out = q|Total sites reporting data: |.$db->quickScalar("select count(distinct(siteId)) from webgui_stats").q{<br /><br />};
    foreach my $type (qw(asset user group package)) {
        $out .= q|Average number of |.$type.q|s per site: |.$db->quickScalar("select sum(".$type."Count) / count(*) from webgui_stats").q{<br />};
    }
    $out .= q{<br />};
    foreach my $type (qw(asset user group package)) {
        my @growth = $db->buildArray("select max(".$type."Count) - min(".$type."Count) from webgui_stats group by siteId");
        my $total = 0;
        ($total += $_) for @growth;
        my $average = $total / scalar(@growth);
        $out .= q|Average |.$type.q| growth: |.$average.q{<br />};
    }
    $out .= q{<br /><b>This is just some preliminary reporting. Once we have more data to report on, we'll introduce a lot more reports, and graphs!</b>};
    return $out;
}

#-------------------------------------------------------------------
sub www_receiveStats {
    my $self = shift;
    my $session = $self->session;
    my $stats = JSON->new->decode($session->form->get('stats'));
    my $assetTypes = $stats->{assetTypes};
    delete $stats->{assetTypes};
    my $submission =  WebGUI::AssetCollateral::WgStats->create($session, $stats);
    foreach my $assetType (@{$assetTypes}) {
        WebGUI::AssetCollateral::WgAssetStats->create($session, {
            submissionId    => $submission->getId,
            quantity        => $assetType->{quantity},
            className       => $assetType->{className},
        });
    }
    $session->http->setMimeType("text/plain");
    return "Submission Received\n";
}

#-------------------------------------------------------------------
sub www_view {
	my $self = shift;
	return $self->getParent->processStyle($self->view);
}

1;

#vim:ft=perl
