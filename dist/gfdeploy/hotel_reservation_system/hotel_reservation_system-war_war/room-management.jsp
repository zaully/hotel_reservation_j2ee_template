<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<div class="container">
    <h1 class="title">Room Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation" class="active"><a href="#room_management_tab">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active" id="room_management_tab">
                <%
                    RoomTypeSessionBeanRemote rsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
                    if (rsb == null) {
                        %> <jsp:forward page="index.jsp" /> <%
                    }
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
                        <th>Type ID</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Lowest Quantity</th>
                        <th>Lowest Date</th>
                        <th>Active</th>
                        <th></th>
                        <th></th>
                    </tr>
                    <%
                        List objs = rsb.getAllRoomTypes(10, 10 * (pageIndex - 1));
                        for (Object obj : objs) {
                            RoomType room = (RoomType)obj;
                            %>
                    <tr>
                        <td><%= room.getRoomTypeId() %></td>
                        <td><%= room.getRoomTypeName() %></td>
                        <td><%= room.getRoomPrice() %></td>
                        <td><%= room.getQuantity() %></td>
                        <td></td>
                        <td></td>
                        <td><%= room.getActivated() ? "YES" : "NO" %></td>
                        <td><a href="room-type-management.jsp?rid=<%= room.getRoomTypeId() %>" class='btn-sm'>Modify</td>
                        <td><a href="delete-room-type.jsp?rid=<%= room.getRoomTypeId() %>" class='btn-sm btn-danger'>Delete</td>
                    </tr>
                            <%
                        }
                    %>
                </table>
                <a href="room-type-management.jsp" class="btn btn-success">Add</a>
                <div class="text-center">
                    <ul class="pagination">
                        <li><a <%= pageIndex != 1 ? "href='room-management.jsp?p=1'" : "" %> ><</a></li>
                        <%
                        int totalRecordCount = rsb.getTotalCount();
                        int totalPageCount = totalRecordCount / 10 + 1;
                        if (totalRecordCount % 10 == 0) {
                            totalPageCount -= 1;
                        }
                        for (int i = 0; i < totalPageCount; i++) {
                            if (pageIndex == i + 1) {
                                %> <li class='active'><a><%= i + 1 %><span class='sr-only'>(current)</span></a></li> <%
                            } else {
                                %> <li><a href='room-management.jsp?p=<%= i + 1 %>'><%= i + 1 %></a></li> <%
                            }
                        }
                    %>
                        <li><a <%= pageIndex != totalPageCount ? "href='room-management.jsp?p=" + totalPageCount + "'" : "" %>>></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>