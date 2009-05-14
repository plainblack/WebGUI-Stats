package WebGUI::AssetCollateral::WgAssetStats;

use strict;
use base 'WebGUI::Crud';


#-------------------------------------------------------------------
sub crud_definition {
    my ($class, $session) = @_;
    my $definition = $class->SUPER::crud_definition($session);
    $definition->{tableName} = 'webgui_asset_stats';
    $definition->{tableKey} = 'assetSubmissionId';
    $definition->{properties}{submissionId} = {
            fieldType       => 'guid',
            defaultValue    => undef,
        };
    $definition->{properties}{quantity} = {
            fieldType       => 'integer',
            defaultValue    => undef,
        };  
    $definition->{properties}{className} = {
            fieldType       => 'text',
            defaultValue    => undef,
        };
    return $definition;
}




1;

