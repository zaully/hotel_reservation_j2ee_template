<%@include file="header.jsp" %>
<div class="container">
    <h1 class="title">Room Type Management</h1>
    <div class="row">
        <div class="login col-md-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="profile-management.jsp">Profile</a></li>
                <li role="presentation"><a href="user-management.jsp">User Management</a></li>
                <li role="presentation"><a href="reservation-management.jsp">Reservation Management</a></li>
                <li role="presentation" class="active"><a href="room-management.jsp">Room Management</a></li>
                <li role="presentation"><a href="amenity-management.jsp">Amenity Management</a></li>
            </ul>
        </div>
        <div class="login col-md-9">
            <div class="tab-pane active">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="input_room_type" class="col-sm-3 control-label">Room Type</label>
                        <div class="col-sm-9">
                            <input name="input_room_type" type="text" class="form-control" id="input_room_type" placeholder="Room Type">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_normal_price" class="col-sm-3 control-label">Price</label>
                        <div class="col-sm-9">
                            <input name="input_normal_price" type="number" class="form-control" id="input_normal_price" placeholder="Normal Price">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_sq_ft" class="col-sm-3 control-label">Sq. Ft.</label>
                        <div class="col-sm-9">
                            <input name="input_sq_ft" type="number" class="form-control" id="input_sq_ft" placeholder="How big are they">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_total_quantity" class="col-sm-3 control-label">Total Quantity</label>
                        <div class="col-sm-9">
                            <input name="input_total_quantity" type="number" class="form-control" id="input_total_quantity" placeholder="How many of this type of rooms we have">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_room_description" class="col-sm-3 control-label">Description</label>
                        <div class="col-sm-9">
                            <textarea name="input_room_description"class="form-control" id="input_room_description" placeholder="How great are they?" rows="8"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="input_amenities" class="col-sm-3 control-label">Amenities</label>
                        <div class="col-sm-6">
                            <select name="input_amenities"class="form-control" id="input_amenities" multiple>
                                <option>
                                    None
                                </option>
                                <option>
                                    Great view
                                </option>
                                <option>
                                    Balcony
                                </option>
                                <option>
                                    Kitchen
                                </option>
                                <option>
                                    Walk-in swimming pool
                                </option>
                            </select>
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