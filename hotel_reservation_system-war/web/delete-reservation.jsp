<%@include file="header.jsp" %>
<%
    ReservationSessionBeanRemote reservationsb = (ReservationSessionBeanRemote) ctx.lookup(ReservationSessionBeanRemote.class.getName());
    if (reservationsb == null) {
%> <jsp:forward page="index.jsp" /> <%
    }
    int rid = 0;
    try {
        rid = Integer.parseInt(request.getParameter("rid"));
    } catch (Exception e) {
%> <jsp:forward page="reservation-management.jsp" /> <%
    }
    Reservation reservation = (Reservation)reservationsb.getReservation(rid);
    User user = (User)ub.getLoggedUser();
    if (user == null || reservation == null || (user.getUserRoleId() != 1 && user.getUserId() != reservation.getUserId())) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    reservationsb.deleteObject(reservation.getReservationId());
    if (user.getUserRoleId() == 1) {
        %> <jsp:forward page="reservation-management.jsp" /> <%
    } else {
        %> <jsp:forward page="profile.jsp" /> <%
    }
%>
