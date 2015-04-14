<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    RoomTypeSessionBeanRemote rsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
    if (rsb == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    int rid = 0;
    if (request.getParameter("rid") != null) {
        try {
            rid = Integer.parseInt(request.getParameter("rid"));
            rsb.deleteObject(rid);
        } catch (Exception e) {
            rid = 0;
        }
        %> <jsp:forward page="room-management.jsp" /> <%
    }
%>
<%@include file="footer.jsp" %>