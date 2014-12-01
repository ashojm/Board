<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.PreparedStatement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>

<%@ page import = "javax.naming.Context" %>
<%@ page import = "javax.naming.InitialContext" %>
<%@ page import = "javax.naming.NamingException" %>
<%@ page import = "javax.sql.DataSource" %>

<% 
	request.setCharacterEncoding("utf-8");
	String seq = request.getParameter("seq");
	
	String subject = "";
	String writer = "";
	String mail = "";
	String wip = "";
	String wdate = "";
	String hit = "";
	String content = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context initctx = new InitialContext();
		Context envCtx = (Context)initctx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		conn = dataSource.getConnection();
		
		String sql = "update board1 set hit=hit+1 where seq = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,seq);
		pstmt.executeUpdate();
		
		sql = "select subject,writer,mail,wip,wdate,hit,content from board1 where seq = ?";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1,seq);
	    
	    rs = pstmt.executeQuery();
	    if(rs.next()){
	    	
	    	subject = rs.getString("subject"); 
	    	writer = rs.getString("writer");
	    	mail = rs.getString("mail") == null? "" : rs.getString("mail");
	    	wdate = rs.getString("wdate");
	    	wip = rs.getString("wip");
	    	hit = rs.getString("hit");
	    	content = rs.getString("content") == null? "" : rs.getString("content").replaceAll("\n", "<br/>");
	    }
		
	}catch(NamingException e){
		System.out.println("Namming error :" + e.getMessage());
	}catch(SQLException e){
		System.out.println("SQL error :" + e.getMessage());
	}
	
	finally{
         if(rs!=null) rs.close();
		 if(pstmt!=null)pstmt.close();
         if(conn!=null) conn.close();
	}
%>

    
<html>
<head>
<title></title>
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<link rel='stylesheet' type='text/css' href='../images/common.css'>
</head>

<body bgcolor='#ffffff' topmargin='5' rightmargin='0' leftmargin='5' bottommargin='10'>

<table width='750px' border='0' cellpadding='0' cellspacing='0' align='center'>
<tr>
	<td height='23' bgcolor='#f0f0f0' align='right'></td>
</tr>
<tr>
	<td bgcolor='#ffffff' style='padding:20'>
		<table width='100%' cellpadding='0' cellspacing='0' border='0' align='center'>
		<tr>
			<td height='25'><font class='titdot'>&#149;&nbsp;</font><font class='title'>제목</font><%=subject%></td>
		</tr>
		<tr>
			<td class='imgline'></td>
		</tr>
		<tr>
			<td height='25'><font class='titdot'>&#149;&nbsp;</font><font class='title'>이름</font><%=writer%>(<%=mail%>) (<%=wip%>)</td>
		</tr>
		<tr>
			<td class='imgline'></td>
		</tr>
		<tr>
			<td height='25'>
				<table width='100%' cellpadding='0' cellspacing='0' border='0' align='center'>
				<tr>
					<td><font class='titdot'>&#149;</font><font class='title'> 날짜</font><%=wdate %></td>
					<td align='right'><font class='titdot'>&#149;&nbsp;</font><font class='title'>조회<%=hit%></td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td  class='imgline'></td>
		</tr>
		<tr>
			<td height='100'><%=content%></td>
		</tr>
		</table>

		<table width='100%' border='0' cellspacing='0' cellpadding='0' align='center'>
		<tr>
			<td id='tailarea'></td>
		</tr>
		</table>

		<table width='100%' border='0' cellspacing='1' cellpadding='1'>
		<tr>
			<td colspan='2' class='gline'></td>
		</tr>
		<tr>
			<td width='500' height='30'>
				<a href='board_write1.jsp'><img src='../images/btn_wri.gif' border='0'></a>				  
				<a href='board_modify1.jsp?seq=<%=seq%>'><img src='../images/btn_mod.gif' border='0'></a>
				<a href='board_delete1.jsp?seq=<%=seq%>'><img src='../images/btn_del.gif' border='0'></a>
			</td>
			<td align='right'>
				<a href='board_list1.jsp'><img src='../images/btn_list.gif' border='0'></a>
			</td>
		</tr>
		<tr>
			<td colspan='2' class='gline'></td>
		</tr>
		</table>
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
