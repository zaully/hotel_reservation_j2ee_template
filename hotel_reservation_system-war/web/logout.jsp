<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">User Portal</h1>
    <%
        ub.logout();
    %>
    <jsp:forward page="index.jsp" />
    <br />
</div>
<%@include file="footer.jsp" %>