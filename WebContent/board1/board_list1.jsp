<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.print.attribute.standard.DateTimeAtCompleted"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
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

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	StringBuffer result = new StringBuffer();
	
	Date date = new Date ();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	
	Date dToday = null;
	Date dwDate = null;
	try{
		//NEW 처리해주기..숙제
		
		Context initctx = new InitialContext();
		Context envCtx = (Context)initctx.lookup("java:comp/env");
		DataSource dataSource = (DataSource)envCtx.lookup("jdbc/oracle");
		conn = dataSource.getConnection();
			
		String sql = 	  "select seq,subject,writer,to_char(wdate,'yy.mm.dd') wdate, hit, case when wdate < sysdate then 'N' " 
        					+ "when wdate >= sysdate then 'Y' end as newPost "    
									+ "from BOARD1 order by seq desc";

	    pstmt = conn.prepareStatement(sql);
	    
	    rs = pstmt.executeQuery();
	    while(rs.next()){
	    	String seq = rs.getString("seq");
	    	String subject = rs.getString("subject");
	    	String writer = rs.getString("writer");
	    	String wdate = rs.getString("wdate");
	    	String hit = rs.getString("hit");
	    	String newPost = rs.getString("newPost");
	  
			result.append("<table width='100%' border='0' cellpadding='0' cellspacing='0'>");
			result.append("<tr>");
			result.append("<td height='1'></td>");
			result.append("</tr>");
			result.append("<tr>");
			result.append("	<td>");
			result.append("		<table width='100%' border='0' cellpadding='0' cellspacing='0'>");
			result.append("			<tr height='25' onMouseOver=\"this.className='evencell'\" onMouseOut=\"this.className=''\">");
			result.append("				<td width='40' align='center'>"+ seq + "</td>");
			result.append("				<td>");
			result.append("					<span style='width:370' class='elltxt'>");
			result.append("						<a href='board_view1.jsp?seq=" + seq + "'>" + subject + "</a>");
			
			if(newPost.equals("Y")){
																result.append("<img src='../images/ico_n.gif' width='8' height='8' border='0' hspace='3'>");
			}
			
			result.append("					</span>");
			result.append("					</td>");
			result.append("				<td width='100' align='center'>" + writer + "</td>");
			result.append("				<td width='80' align='center'>" + wdate +"</td>");
			result.append("				<td width='50' align='center'>" + hit +"</td>");
			result.append("			</tr>");
			result.append("		</table>");
			result.append("	</td>");
			result.append("</tr>");
			result.append("<tr>");
			result.append("	<td height='1'></td>");
			result.append("</tr>");
			result.append("<tr>");
			result.append("	<td align='center' class='imgline'></td>");
			result.append("</tr>");
			result.append("</table>");
			
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
		<table width='100%' border='0' cellpadding='0' cellspacing='0'>
		<tr>
			<td align='center' class='gline'></td>
		</tr>
		<tr>
			<td align='center'>
				<table width='100%' border='0' cellpadding='0' cellspacing='0' class='titlecell'>
				<tr height='25' align='center'>
					<td width='40'>No</td>
					<td>제목</td>
					<td width='100'>이름</td>
					<td width='80'>등록일</td>
					<td width='50'>조회수</td>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align='center' class='gline'></td>
		</tr>
		<tr>
			<td height='3'></td>
		</tr>
		</table>
		<%=result%> 

		<table width='100%' border='0' cellpadding='0' cellspacing='0'>
		<tr>
			<td width='500' height='30'>&nbsp;</td>
			<td align='right'>
				<a href='board_write1.jsp'><img src='../images/btn_wri.gif' border='0'></a>
			</td>
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
