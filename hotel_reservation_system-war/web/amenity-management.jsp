<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null || user.getUserRoleId() != 1) {
        %> <jsp:forward page="index.jsp" /> <%
    }
%>
<div class="container">
    <h1 class="title">Amenity Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation" class="active"><a href="#amenity_management_tab">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div id="index-tab-content" class="tab-content">
                <div class="tab-pane active" id="amenity_management_tab">
                    <%
                        AmenitySessionBeanRemote as = (AmenitySessionBeanRemote)ctx.lookup(AmenitySessionBeanRemote.class.getName());
                        if (as == null) {
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
                            <th>id</th>
                            <th>Amenity</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <%
                            List amenityObjs = as.getAllAmenities(2, 2 * (pageIndex - 1));
                            for (Object amenityObj : amenityObjs) {
                                Amenity amenity = (Amenity)amenityObj;
                                %>
                        <tr>
                            <th><%= amenity.getAmenityId() %></th>
                            <td><%= amenity.getAmenityName()%></td>
                            <td>
                                <%= amenity.getAmenityDescription()%>
                            </td>
                            <td><a href="edit-amenity.jsp?aid=<%= amenity.getAmenityId() %>" class='btn-sm'>Modify</td>
                            <td><a href="delete-amenity.jsp?aid=<%= amenity.getAmenityId() %>" class='btn-sm btn-danger'>Delete</td>
                        </tr>
                                <%
                            }
                        %>
                    </table>
                    <a href="edit-amenity.jsp" class="btn btn-success">Add</a>
                    <div class="text-center">
                        <ul class="pagination">
                        <li><a <%= pageIndex != 1 ? "href='amenity-management.jsp?p=1'" : "" %> ><</a></li>
                            <%
                            int totalRecordCount = as.getTotalCount();
                            int totalPageCount = totalRecordCount / 2 + 1;
                            for (int i = 0; i < totalPageCount; i++) {
                                if (pageIndex == i + 1) {
                                    %> <li class='active'><a><%= i + 1 %><span class='sr-only'>(current)</span></a></li> <%
                                } else {
                                    %> <li><a href='amenity-management.jsp?p=<%= i + 1 %>'><%= i + 1 %></a></li> <%
                                }
                            }
                        %>
                        <li><a <%= pageIndex != totalPageCount ? "href='amenity-management.jsp?p=" + totalPageCount + "'" : "" %>>></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>