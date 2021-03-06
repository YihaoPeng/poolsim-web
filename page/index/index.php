<?php
Admin::checkLogin();
$tpl = $PAGE->start();

$pageSize = 10;

$size = SimConfig::getConfigSize();
$page = (int) $_GET['page'];

$maxPage = ceil($size / $pageSize);

if ($page < 1) {
    $page = 1;
}
elseif ($page > $maxPage) {
    $page = $maxPage;
}

$offset = ($page - 1) * $pageSize;

$tpl->assign('pageSize', $pageSize);
$tpl->assign('size', $size);
$tpl->assign('page', $page);
$tpl->assign('maxPage', $maxPage);
$tpl->assign('offset', $offset);


$meta = new MetaData('pool_server');
$configList = SimConfig::getConfigList($offset, $pageSize);
$serviceList = [];

foreach ($configList as $config) {
    $service = new SimService($config);
    $service->status = $service->getCountData();
    
    $address = $service->config->ss_ip.':'.$service->config->ss_port;

    $service->poolName = $meta->key($address);

    if ($service->poolName === NULL) {
        $service->poolName = $address;
        $service->isCustomPool = true;
    }

    $serviceList[] = $service;
}

$tpl->assign('serviceList', $serviceList);

$tpl->display('tpl:index');

