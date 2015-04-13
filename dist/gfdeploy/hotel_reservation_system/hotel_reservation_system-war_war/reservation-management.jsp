<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<div class="container">
    <h1 class="title">Reservation Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation" class="active"><a href="#reservation_management_tab">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="reservation_management_tab">
                <%
                    ReservationSessionBeanRemote rsb = (ReservationSessionBeanRemote)ctx.lookup(ReservationSessionBeanRemote.class.getName());
                    RoomTypeSessionBeanRemote roomsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
                    if (rsb == null || roomsb == null) {
                        %> <jsp:forward page="index.jsp" /> <%
                    }
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    int pageIndex = 1;
                    if (request.getParameter("p") != null) {
                        try {
                            pageIndex = Integer.parseInt(request.getParameter("p"));
                        } catch (Exception e) {
                            pageIndex = 1;
                        }
                    }
                    Date from_date;
                    try {
                        from_date = df.parse(request.getParameter("from"));
                    } catch (Exception e) {
                        from_date = null;
                    }
                    Date to_date;
                    try {
                        to_date = df.parse(request.getParameter("to"));
                    } catch (Exception e) {
                        to_date = null;
                    }
                    String strFrom = from_date != null ? df.format(from_date) : "";
                    String strTo = to_date != null ? df.format(to_date) : "";
                %>
                <form id='timeform' name='timeform' class='wowload fadeInRight' method='GET'>
                    <table>
                        <tr>
                            <th>From:</th>
                            <th>To:</th>
                        </tr>
                        <tr>
                            <td>
                                <input id='from' name='from' value='<%= strFrom %>' />
                            </td>
                            <td>
                                <input id='to' name='to' value='<%= strTo %>' />
                            </td>
                        </tr>
                    </table>
                    <br>
                    <input type='submit' class="btn btn-sm btn-default" value='Find' />
                </form>
                <br>
                    <table class='table wowload fadeInRight'>
                        <tr>
                            <th>Client</th>
                            <th>Starting from</th>
                            <th>Ends at</th>
                            <th>Room type</th>
                            <th>Rooms</th>
                            <th>Overall Price</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <%
                            List objs = rsb.getAllReservation(50, 50 * (pageIndex - 1), from_date, to_date);
                            for (Object obj : objs) {
                                Reservation reservation = (Reservation)obj;
                                User bookedUser = (User)ub.getUserByUID(reservation.getUserId());
                                RoomType rt = (RoomType)roomsb.getRoomTypeDetails(reservation.getRoomTypeId());
                                %>
                        <tr>
                            <td><%= bookedUser.getName() %></td>
                            <td><%= df.format(reservation.getStartsFrom()) %></td>
                            <td><%= df.format(reservation.getEndsAt()) %></td>
                            <td><%= rt.getRoomTypeName()%></td>
                            <td><%= reservation.getRoomsQuantity() %></td>
                            <td>$<%= rt.getRoomPrice()%></td>
                            <td><a href="reservation-details.jsp?rid=<%= reservation.getReservationId() %>" class='btn-sm'>Check</td>
                            <td><a href="delete-reservation.jsp?rid=<%= reservation.getReservationId() %>" class='btn-sm btn-danger'>Delete</td>
                        </tr>
                                <%
                            }
                        %>
                    </table>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a <%= pageIndex != 1 ? "href='reservation-management.jsp?p=1'" : "" %> ><</a></li>
                            <%
                            int totalRecordCount = rsb.getTotalCount(from_date, to_date);
                            int totalPageCount = totalRecordCount / 10 + 1;
                            for (int i = 0; i < totalPageCount; i++) {
                                if (pageIndex == i + 1) {
                                    %> <li class='active'><a><%= i + 1 %><span class='sr-only'>(current)</span></a></li> <%
                                } else {
                                    %> <li><a href='reservation-management.jsp?p=<%= i + 1 %>'><%= i + 1 %></a></li> <%
                                }
                            }
                        %>
                            <li><a <%= pageIndex != totalPageCount ? "href='reservation-management.jsp?p=" + totalPageCount + "'" : "" %>>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>