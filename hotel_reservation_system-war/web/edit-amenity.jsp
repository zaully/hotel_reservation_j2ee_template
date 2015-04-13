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
    Amenity amenity = null;
    if (request.getParameter("aid") != null) {
        try {
            aid = Integer.parseInt(request.getParameter("aid"));
            amenity = (Amenity)as.getAmenityByAID(aid);
        } catch (Exception e) {
            aid = 0;
        }
    }
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        Boolean create = false;
        if (amenity == null) {
            create = true;
            amenity = new Amenity();
        }
        amenity.setAmenityName(request.getParameter("input_amenity_name"));
        amenity.setAmenityDescription(request.getParameter("input_amenity_description"));
        Boolean result = false;
        if (create) {
            result = as.createAmenity(amenity);
        } else {
            result = as.saveChange(amenity);
        }
        if (result) {
            %> <jsp:forward page="amenity-management.jsp" /> <%
        }
    }
%>
<div class="container">
    <h1 class="title"><%= request.getParameter("aid") != null ? "Edit" : "Create" %> Amenity</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation" class="active"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active">
                <form action='edit-amenity.jsp<%= amenity != null ? "?aid=" + amenity.getAmenityId() : "" %>' method="POST" class="form-horizontal">
                    <div class="form-group">
                        <label for="field_id" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input name="field_id" type="text" class="form-control" id="field_id" readonly value="<%= amenity != null ? amenity.getAmenityId() : "Creating" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenity_name" class="col-sm-3 control-label">Amenity</label>
                        <div class="col-sm-9">
                            <input name="input_amenity_name" type="text" class="form-control" id="input_amenity_name" placeholder="Amenity" value="<%= amenity != null ? amenity.getAmenityName() : "" %>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenity_description" class="col-sm-3 control-label">Description</label>
                        <div class="col-sm-9">
                            <textarea name="input_amenity_description"class="form-control" id="input_amenity_description" placeholder="How great is it?" rows="8"><%= amenity != null ? amenity.getAmenityDescription(): "" %></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <div class="checkbox">
                          <label>
                            <input name='input_active' type="checkbox"> Active
                          </label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <input type="submit" class="btn btn-success" value='<%= amenity != null ? "Save" : "Create" %>' />
                      </div>
                    </div>
                  </form>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>