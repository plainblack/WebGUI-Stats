package WebGUI::AssetCollateral::WgStats;

use Moose;
use WebGUI::Definition::Crud;
extends 'WebGUI::Crud';

define tableName => 'webgui_stats';
define tableKey => 'submissionId';
has submissionId => (
    fieldType   => 'guid',
);

property siteId => (
    fieldType   => 'guid',
);

property webguiVersion => (
    fieldType   => 'text',
);

property perlVersion => (
    fieldType   => 'text',
);

property apacheVersion => (
    fieldType   => 'text',
);

property osType => (
    fieldType   => 'text',
);

property userCount => (
    fieldType   => 'integer',
);

property groupCount => (
    fieldType   => 'integer',
);

property assetCount => (
    fieldType => 'integer',
);

property packageCount => (
    fieldType => 'integer',
);

1;

