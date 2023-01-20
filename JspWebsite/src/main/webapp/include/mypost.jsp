<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function selectAll(selectAll)  {
		  const checkboxes = document.getElementsByName("delmypost");
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked;
		  })
	}
</script>

<script type="text/javascript">
	function del_confirm() {
		var formDelete = document.formDelete;
		var ok = confirm('선택한 글을 모두 삭제하시겠습니까?');
		if (ok) {
			formDelete.method = "post";
			formDelete.action = "ServletDelMypost";
			formDelete.submit();
		} else {
			location.href = "mypage.jsp";
		}
	}
</script>
</head>
<body>
	<%
	MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
	Board bo = new Board();
	int cupm;
	if (request.getParameter("page").equals(null)) {
		cupm = 1;
	} else {
		cupm = Integer.parseInt(request.getParameter("page"));
	}
	ArrayList<PostDTO> mypost = bo.mypost(me.getId(), cupm);
	%>
	<form name="formDelete" method="post" action="ServletDelMypost"
		encType="UTF-8">
		<span id="t">내가 쓴 글</span> <br>
		<div class="list">
			<div class="list_m">
				<div class="list_n" style="background-color: white;">
					<div>
						<input type="checkbox" name="all" value="selectall"
							onclick="selectAll(this)">
					</div>
					<div>게시판</div>
					<div>제목</div>
					<div>♡</div>
					<div>조회수</div>
					<hr>
				</div>
				<div class="list_z">
					<%
					if (mypost.size() != 0) {
						for (PostDTO p : mypost) {
							String category = bo.switchCategory(p.getCategory());
							String title = "";
							if (p.getTitle().length() > 16) {
						title = p.getTitle().substring(0, 16) + "...";
							} else {
						title = p.getTitle();
							}
					%>
					<div class="list_n">
						<div>
							<input type="checkbox" name="delmypost" value="<%=p.getpNum()%>">
						</div>
						<div><%=category%></div>
						<div style="text-align: left;">
							<a
								href="read.jsp?postNum=<%=p.getpNum()%>&category=<%=p.getCategory()%>&page=1"><%=title%></a>
							<%
							if (p.getReply() > 0) {
							%>
							(<%=p.getReply()%>)
							<%
							}
							%>
						</div>
						<div><%=p.getHeart()%></div>
						<div><%=p.getViews()%></div>
					</div>
					<%
					}
					%>
					<input type="button" value="삭제" onclick="del_confirm()"
						style="width: 40px; height: 25px; font-size: 0.7em; background-color: #d2eed7;">
					<br>
					<%
					} else {
					%>
					<div>작성한 글이 없습니다.</div>
					<%
					}
					%>
				</div>
				<div class="page">
					<%@ include file="pageMypage.jsp"%>
				</div>
			</div>
		</div>
	</form>
</body>
</html>