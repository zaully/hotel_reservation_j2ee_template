<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<div class="container">
    <h1 class="title">User Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation" class="active"><a href="#user_management_tab">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="user_management_tab">
                    <%
                    ReservationSessionBeanRemote rsb = (ReservationSessionBeanRemote)ctx.lookup(ReservationSessionBeanRemote.class.getName());
                        int pageIndex = 1;
                        if (request.getParameter("p") != null) {
                            try {
                                pageIndex = Integer.parseInt(request.getParameter("p"));
                            } catch (Exception e) {
                                pageIndex = 1;
                            }
                        } 
                    %>
                    <table class='table wowload fadeInRight'>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Member since</th>
                            <th>Last visit</th>
                            <th>Visits</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <%
                            List userObjs = ub.getUsers(10, 10 * (pageIndex - 1));
                            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                            for (Object userObj : userObjs) {
                                User u = (User)userObj;
                                %>
                        <tr>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail()%></td>
                            <td><%= u.getPhone()%></td>
                            <td><%= u.getCreatedAt() != null ? df.format(u.getCreatedAt()) : "" %></td>
                            <%
                                Date lastVisit = rsb.getLastVisitByUserID(u.getUserId());
                                String strLast = "-";
                                if (lastVisit != null)
                                    strLast = df.format(lastVisit);
                            %>
                            <td><%= strLast %></td>
                            <td><%= rsb.getVisitsByUserID(u.getUserId()) %></td>
                            <td><a href="user-details.jsp?uid=<%= u.getUserId() %>" class='btn-sm'>Check Details</td>
<!--                            <td><a href="" class='btn-sm btn-danger'>Delete</td>-->
                        </tr>
                                <%
                            }
                        %>
                    </table>
                    <div class="text-center">
                        <ul class="pagination">
                        <li><a <%= pageIndex != 1 ? "href='user-management.jsp?p=1'" : "" %> ><</a></li>
                            <%
                            int totalRecordCount = ub.getUsersPageCount();
                            int totalPageCount = totalRecordCount / 10 + 1;
                            if (totalRecordCount % 10 == 0) {
                                totalPageCount -= 1;
                            }
                            for (int i = 0; i < totalPageCount; i++) {
                                if (pageIndex == i + 1) {
                                    %> <li class='active'><a><%= i + 1 %><span class='sr-only'>(current)</span></a></li> <%
                                } else {
                                    %> <li><a href='user-management.jsp?p=<%= i + 1 %>'><%= i + 1 %></a></li> <%
                                }
                            }
                        %>
                        <li><a <%= pageIndex != totalPageCount ? "href='user-management.jsp?p='" + totalPageCount : "" %>>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>