<?php echo $header;
function randomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, strlen($characters) - 1)];
    }
    return $randomString;
}
$secKey = ((isset($modules['secure_key']))   ? $modules['secure_key']   : 'secure_key' );
$secVal = ((isset($modules['secure_value'])) ? $modules['secure_value'] : randomString() );
?>


<div id="content">
<div class="breadcrumb">
	<?php foreach ($breadcrumbs as $breadcrumb) { ?>
	<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
	<?php } ?>
</div>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box">

	<div class="heading">
		<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').submit();" class="button">
				<?php echo $button_save; ?></a>
			<a href="<?php echo $cancel; ?>" class="button">
				<?php echo $button_cancel; ?></a>
		</div>
	</div>

	<div class="content">
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
			<table id="module" class="list">
				<h3>Administrator Key</h3>
				<tr>
					<td class="left">Status</td>
					<td>
						<select name="secure_status">
							<?php if ($modules['secure_status']) { ?>
							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
							<option value="0"><?php echo $text_disabled; ?></option>
							<?php } else { ?>
							<option value="1"><?php echo $text_enabled; ?></option>
							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
							<?php } ?>
						</select>
					</td>
				</tr>

				<tr>
					<td class="left">Secure Key</td>
					<td>
						<input type="text" name="secure_key" onchange="ChangeUrl();" value="<?php echo $secKey; ?>"  />
					</td>
				</tr>
				<tr>
					<td class="left">Secure Value</td>
					<td>
						<input type="text" name="secure_value" onchange="ChangeUrl();" value="<?php  echo $secVal; ?>"  />
					</td>
				</tr>
			</table>
			<h3 id="finalURL" style="color: blue;"></h3>
		</form>
	</div>
</div>
</div>
<script type="text/javascript">

function ChangeUrl() {
    var url = document.URL.substring(0, document.URL.indexOf("index"))
    url += "?" + $('[name="secure_key"]').val()
    url += "=" + $('[name="secure_value"]').val()
	$('#finalURL').html(url);
}
$(document).ready(function() { ChangeUrl() });

</script>
<?php echo $footer; ?>
