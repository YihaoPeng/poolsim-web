{include file="tpl:comm.head" title="矿机模拟器管理面板"}
<style>
</style>
<div id="title" class="tp">
    <h3>矿机模拟器管理面板 | <a href="{$CID}.index.{$BID}">返回首页</a></h3>
</div>
<div id="add_form">
    <form action="{$CID}.{$PID}.{$BID}?id={$config->id|code}" method="post">
        <p>
            矿池：
			{if $smarty.get.custom_pool}
                <input type="text" name="pool" value="{$config->ss_ip|code}:{$config->ss_port|code}" />
                <a href="?id={$config->id|code}&custom_pool=0">预定义</a>
            {else}
            <select name="pool">
                {foreach $poolList as $name=>$address}
                    <option value="{$address|code}" {if $address == "{$config->ss_ip}:{$config->ss_port}"}selected{/if}>{$name|code}</option>
                {/foreach}
            </select>
            <a href="?id={$config->id|code}&custom_pool=1">自定义</a>
			{/if}
        </p>
        <p>子账户名：<input type="text" name="username" value="{$config->username|code}" /></p>
        <p>矿机数：<input type="text" name="number" value="{$config->number_clients|code}" /></p>
        <p><input type="submit" name="edit" value="提交" /></p>
    </form>
</div>
<div id="error_message" class="failure">
    {$errMsg|code}
</div>
{include file="tpl:comm.foot"}
