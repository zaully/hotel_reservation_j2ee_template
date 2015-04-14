<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null) {
        %> <jsp:forward page="login.jsp" /> <%
    }
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        user.setName(request.getParameter("name"));
        user.setPhone(request.getParameter("phone"));
        if (request.getParameter("password") != null && request.getParameter("password").length() > 6) {
            user.setPassword(request.getParameter("password"));
        }
        user.setPreference(request.getParameter("preference"));
    }
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
    Date dtFrom = Calendar.getInstance().getTime();
%>
<div class="container">
    <h1 class="title">User Details</h1>
    <div class="row">
        <div class="login col-md-2">
    <%
    int activatedTab = 2;
    if(request.getMethod().compareToIgnoreCase("post") == 0 && request.getParameter("modify_profile") != null)
        activatedTab = 1;
    %>
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" <%= activatedTab == 1 ? "class='active'" : "" %> ><a href="#index_profile_tab" data-toggle="pill">Profile</a></li>
                <li role="presentation" <%= activatedTab == 2 ? "class='active'" : "" %> ><a href="#index_reservation_tab" data-toggle="pill">Reservation</a></li>
            </ul>
        </div>
        <div class="login col-md-10">
            <%
                if(request.getMethod().compareToIgnoreCase("post") == 0 && request.getParameter("modify_profile") != null) {
                    if (ub.saveChange(user)) {
            %>
            <div class="alert alert-success alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" 
                   aria-hidden="true">
                   &times;
                </button>
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Success:</span>Saving change succeeded
            </div>
            <% } else { %>
            <div class="alert alert-danger alert-dismissable" role="alert">
                <button type="button" class="close" data-dismiss="alert" 
                   aria-hidden="true">
                   &times;
                </button>
                <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                <span class="sr-only">Error:</span>Saving change failed
            </div>
            <% } } %>
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane <%= activatedTab == 1? "active" : "" %>" id="index_profile_tab">
                    <form action='profile.jsp' method='POST' role="form" class="wowload fadeInRight">
                        <div class="form-group">
                            <input name='email' type="email" class="form-control" readonly value="<%= user.getEmail() %>" placeholder="Email (will be your username)">
                        </div>
                        <div class="form-group">
                            <input name='name' type="text" class="form-control" value="<%= user.getName() %>" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <input name='phone' type="Phone" class="form-control" value="<%= user.getPhone() %>" placeholder="Phone">
                        </div>
                        <div class="form-group">
                            <input name='password' type="password" class="form-control" placeholder="Password (Leave blank if you don't want to change it)">
                        </div>
                        <div class="form-group">
                            <input name='password_confirm' type="password" class="form-control"  placeholder="Confirm your password">
                        </div>
                        <div class="form-group">
                            <textarea name='preference' class="form-control" placeholder="Your preference" rows="5"><%= user.getPreference() %></textarea>
                        </div>
                        <input type='submit' name='modify_profile' value='Modify' class="btn btn-default" />
                    </form>
                </div>
                <div class="tab-pane <%= activatedTab == 2? "active" : "" %>" id="index_reservation_tab">
                    <table class='table'>
                        <tr>
                            <th>Starting from</th>
                            <th>Ends at</th>
                            <th>Room type</th>
                            <th>Rooms</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <%
                            List objs = rsb.getAllReservation(user.getUserId(), 0, 10, 10 * (pageIndex - 1), dtFrom, null);
                            for (Object obj : objs) {
                                Reservation reservation = (Reservation)obj;
                                RoomType rt = (RoomType)roomsb.getRoomTypeDetails(reservation.getRoomTypeId());
                                %>
                        <tr>
                            <td><%= df.format(reservation.getStartsFrom()) %></td>
                            <td><%= df.format(reservation.getEndsAt()) %></td>
                            <td><%= rt.getRoomTypeName() %></td>
                            <td><%= reservation.getRoomsQuantity() %></td>
                            <td><a href="book-room.jsp?res=<%= reservation.getReservationId() %>" class='btn-sm'>Modify</td>
                            <td><a href="delete-reservation.jsp?rid=<%= reservation.getReservationId() %>" class='btn-sm btn-danger'>Cancel</td>
                        </tr>
                                <%
                            }
                        %>
                    </table>
                    <div class="text-center">
                        <ul class="pagination">
                            <li><a <%= pageIndex != 1 ? "href='profile.jsp?p=1'" : "" %> ><</a></li>
                            <%
                            int totalRecordCount = rsb.getTotalCount(dtFrom, null);
                            int totalPageCount = totalRecordCount / 10 + 1;
                            if (totalRecordCount % 10 == 0) {
                                totalPageCount -= 1;
                            }
                            for (int i = 0; i < totalPageCount; i++) {
                                if (pageIndex == i + 1) {
                                    %> <li class='active'><a><%= i + 1 %><span class='sr-only'>(current)</span></a></li> <%
                                } else {
                                    %> <li><a href='profile.jsp?p=<%= i + 1 %>'><%= i + 1 %></a></li> <%
                                }
                            }
                        %>
                            <li><a <%= pageIndex != totalPageCount ? "href='profile.jsp?p=" + totalPageCount + "'" : "" %>>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>