package WebGUI::AssetCollateral::WgAssetStats;

use Moose;
use WebGUI::Definition::Crud;
extends 'WebGUI::Crud';

define tableName => 'webgui_asset_stats';
define tableKey  => 'assetSubmissionId';
define sequenceKey => 'submissionId';
property assetSubmissionId => (
    fieldType   => 'text',
);
property submissionId => (
    fieldType   => 'guid',
);

property quantity => (
    fieldType   => 'integer',
);

property className => (
    fieldType   => 'text',
);

1;

