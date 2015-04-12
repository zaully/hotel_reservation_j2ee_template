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
                <li role="presentation" class="active"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="field_id" class="col-sm-3 control-label">ID</label>
                        <div class="col-sm-9">
                            <input name="field_id" type="text" class="form-control" id="field_id" readonly value="new / 1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenity_name" class="col-sm-3 control-label">Amenity</label>
                        <div class="col-sm-9">
                            <input name="input_amenity_name" type="text" class="form-control" id="input_amenity_name" placeholder="Amenity">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenity_description" class="col-sm-3 control-label">Description</label>
                        <div class="col-sm-9">
                            <textarea name="input_amenity_description"class="form-control" id="input_amenity_description" placeholder="How great is it?" rows="8"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <div class="checkbox">
                          <label>
                            <input type="checkbox"> Active
                          </label>
                        </div>
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="col-sm-offset-3 col-sm-9">
                        <button type="submit" class="btn btn-success">Save</button>
                      </div>
                    </div>
                  </form>
            </div>
        </div>
    </div>
    <br />
</div>
<%@include file="footer.jsp" %>