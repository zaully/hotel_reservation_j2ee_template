<%@include file="header.jsp" %>
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
                    <table class='table wowload fadeInRight'>
                        <tr>
                            <th>id</th>
                            <th>Amenity</th>
                            <th>Description</th>
                            <th></th>
                            <th></th>
                        </tr>
                        <tr>
                            <th>1</th>
                            <td>Balcony</td>
                            <td>
                                Very very long Very very long Very very long very long Very very long Very very long Very very long Very very long very long Very very long Very very long Very very long Very very long very long Very very long
                            </td>
                            <td><a href="edit-amenity.jsp" class='btn-sm'>Modify</td>
                            <td><a href="" class='btn-sm btn-danger'>Delete</td>
                        </tr>
                    </table>
                    <a href="edit-amenity.jsp" class="btn btn-success">Add</a>
                </div>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>