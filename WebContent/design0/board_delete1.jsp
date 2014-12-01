<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<link rel='stylesheet' type='text/css' href='../images/common.css'>
<script type="text/javascript">
	function ChkForm(form) {
	}
</script>
</head>

<body bgcolor='#ffffff' topmargin='5' rightmargin='0' leftmargin='5' bottommargin='10'>

<table width='750px' border='0' cellpadding='0' cellspacing='0' align='center'>
<tr>
	<td height='23' bgcolor='#f0f0f0' align='right'></td>
</tr>
<tr>
	<td bgcolor='#ffffff' style='padding:20'>
		<form action='' method='post' name='wfrm' onSubmit='return ChkForm(this)'>
		<table width='100%' border='0' cellpadding='0' cellspacing='0'>
		<tr>
			<td width='70' style='padding:5' valign='top' align='right'>
				<font class='titdot'>&#149;&nbsp;</font>
				<font class='title'>제목</font> :
			</td>
			<td>
				<input type='text' name='subject' value='' size='80' class='form' readonly>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='imgline'></td>
		</tr>
		<tr>
			<td width='70' style='padding:5' valign='top' align='right'>
				<font class='titdot'>&#149;&nbsp;</font>
				<font class='title'>작성자</font> :
			</td>
			<td>
				이름&nbsp;&nbsp;<input type='text' name='writer' value='' size='10' maxlength='10' class='form' readonly>&nbsp;&nbsp;/&nbsp;
				메일&nbsp;&nbsp;<input type='text' name='mail' value='' size='40' maxlength='70' class='form' readonly>&nbsp;&nbsp;/&nbsp;
				암호&nbsp;&nbsp;<input type='password' name='password' size='10' maxlength='10' class='form'>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='gline'></td>
		</tr>
		</table>

		<table width='100%' cellpadding='0' cellspacing='0' border='0'>
		<tr>
			<td width='500' height='30'>&nbsp;</td>
			<td align='right'>
				<input type='image' src='../images/btn_del.gif' border='0'>&nbsp;
				<a href='board_list1.jsp'><img src='../images/btn_list.gif' border='0'></a>&nbsp;
				<a href='javascript:history.back();'><img src='../images/btn_view.gif' border='0'></a>
			</td>
		</tr>
		</table>
		</form>
	</td>
</tr>
</table>		
		
<table width='750px' border='0' cellpadding='0' cellspacing='0' align='center'>
<tr>
	<td height='15' bgcolor='#f0f0f0' style='padding:5' align='center'></td>
</tr>
</table>

</body>
</html>
