<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    AmenitySessionBeanRemote as = (AmenitySessionBeanRemote)ctx.lookup(AmenitySessionBeanRemote.class.getName());
    if (as == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    int aid = 0;
    if (request.getParameter("aid") != null) {
        try {
            aid = Integer.parseInt(request.getParameter("aid"));
            as.deleteAmenity(aid);
        } catch (Exception e) {
            aid = 0;
        }
        %> <jsp:forward page="amenity-management.jsp" /> <%
    }
%>
<%@include file="footer.jsp" %>