package WebGUI::AssetCollateral::WgStats;

use strict;
use base 'WebGUI::Crud';


#-------------------------------------------------------------------
sub crud_definition {
    my ($class, $session) = @_;
    my $definition = $class->SUPER::crud_definition($session);
    $definition->{tableName} = 'webgui_stats';
    $definition->{tableKey} = 'submissionId';
    $definition->{properties}{siteId} = {
            fieldType       => 'guid',
            defaultValue    => undef,
        };
    $definition->{properties}{webguiVersion} = {
            fieldType       => 'text',
            defaultValue    => undef,
        };
    $definition->{properties}{perlVersion} = {
            fieldType       => 'text',
            defaultValue    => undef,
        };
    $definition->{properties}{apacheVersion} = {
            fieldType       => 'text',
            defaultValue    => undef,
        };
    $definition->{properties}{osType} = {
            fieldType       => 'text',
            defaultValue    => undef,
        };  
    $definition->{properties}{userCount} = {
            fieldType       => 'integer',
            defaultValue    => undef,
        };  
    $definition->{properties}{groupCount} = {
            fieldType       => 'integer',
            defaultValue    => undef,
        };  
    $definition->{properties}{assetCount} = {
            fieldType       => 'integer',
            defaultValue    => undef,
        };  
    $definition->{properties}{packageCount} = {
            fieldType       => 'integer',
            defaultValue    => undef,
        };  
    return $definition;
}




1;

