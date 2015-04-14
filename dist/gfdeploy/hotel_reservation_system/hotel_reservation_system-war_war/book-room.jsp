<%@page import="java.util.Calendar"%>
<%@include file="header.jsp" %>
<%
    User user = (User)ub.getLoggedUser();
    if (user == null) {
        %> <jsp:forward page="login.jsp" /> <%
    }
    int rid = 1;
    if (request.getParameter("rid") != null) {
        try {
            rid = Integer.parseInt(request.getParameter("rid"));
        } catch (Exception e) {
            %> <jsp:forward page="index.jsp" /> <%
        }
    }
    RoomTypeSessionBeanRemote roomsb = (RoomTypeSessionBeanRemote)ctx.lookup(RoomTypeSessionBeanRemote.class.getName());
    if (roomsb == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    RoomType room = (RoomType)roomsb.getRoomTypeDetails(rid);
    if (room == null) {
        %> <jsp:forward page="index.jsp" /> <%
    }
    Boolean result = false;
    if (request.getMethod().compareToIgnoreCase("post") == 0) {
        try {
            ReservationSessionBeanRemote rsb = (ReservationSessionBeanRemote)ctx.lookup(ReservationSessionBeanRemote.class.getName());
            Calendar cldfrom = Calendar.getInstance();
            cldfrom.set(Calendar.YEAR, Integer.parseInt(request.getParameter("from-year")));
            cldfrom.set(Calendar.MONTH, Integer.parseInt(request.getParameter("from-month")));
            cldfrom.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("from-day")));
            Calendar cldto = Calendar.getInstance();
            cldto.set(Calendar.YEAR, Integer.parseInt(request.getParameter("to-year")));
            cldto.set(Calendar.MONTH, Integer.parseInt(request.getParameter("to-month")));
            cldto.set(Calendar.DAY_OF_MONTH, Integer.parseInt(request.getParameter("to-day")));
            int quantity = Integer.parseInt(request.getParameter("rooms"));
            String additional_message = request.getParameter("additional_message");
            result = rsb.reserve(rid, user.getUserId(), cldfrom.getTime(), cldto.getTime(), quantity, additional_message);
            %> <jsp:forward page="profile.jsp" /> <%
        } catch (Exception e) {
            result = false;
        }
    }
%>
<div class="container">
<h2>Room Reservation</h2>
    <!-- reservation-information -->
    <div id="information" class="spacer-sm reserve-info ">
        <div class="container">
            <div class="row">
                <div class="col-sm-7 col-md-8">
                    <div id="RoomDetails" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <div class="item active"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg" class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg"  class="img-responsive" alt="slide"></div>
                        <div class="item  height-full"><img src="images/photos/<%= r.nextInt(4) + 8 %>.jpg"  class="img-responsive" alt="slide"></div>
                        </div>
                        <!-- Controls -->
                        <a class="left carousel-control" href="#RoomDetails" role="button" data-slide="prev"><i class="fa fa-angle-left"></i></a>
                        <a class="right carousel-control" href="#RoomDetails" role="button" data-slide="next"><i class="fa fa-angle-right"></i></a>
                    </div>
                </div>
                <div class="col-sm-5 col-md-4">
                <%
                if(request.getMethod().compareToIgnoreCase("post") == 0 && result == false) {
                %>
                <div class="alert alert-danger alert-dismissable" role="alert">
                    <button type="button" class="close" data-dismiss="alert" 
                       aria-hidden="true">
                       &times;
                    </button>
                    <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
                    <span class="sr-only">Error:</span>Reservation failed!
                </div>
                <% }%>
                    <div id="index-tab-content" class="tab-content">
                        <br />
                        <div class="tab-pane active" id="book_info_form">
                            <form action="book-room.jsp" method='POST' role="form" class="wowload fadeInRight">
                                <input name='rid' type='hidden' value='<%= room.getRoomTypeId() %>' />
                                <input name='uid' type='hidden' value='<%= user.getUserId() %>' />
                                <div class="form-group">
                                    <input name='name' type="text" value='<%= user.getName() %>' readonly class="form-control"  placeholder="Name">
                                </div>
                                <div class="form-group">
                                    <input name='email' type="email" value='<%= user.getEmail() %>' readonly class="form-control"  placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <input name='phone' type="Phone" value='<%= user.getPhone() %>' readonly class="form-control"  placeholder="Phone">
                                </div>        
                                <div class="form-group">
                                    <div class="row">
                                    <div class="col-xs-6">
                                    <select name='rooms' class="form-control">
                                      <option selected disabled>No. of Rooms</option>
                                      <option value="1">1</option>
                                      <option value="2">2</option>
                                      <option value="3">3</option>
                                    </select>
                                    </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                            From
                                        </div>
                                    <div class="col-xs-3">
                                      <select class="form-control col-sm-2" name="from-day" id="to-day">
                                        <option selected disabled>Date</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                        <option value="31">31</option>
                                      </select>
                                    </div>
                                    <div class="col-xs-4">
                                      <select class="form-control col-sm-2" name="from-month" id="to-month">
                                        <option>Month</option>
                                        <option value="0">Jan (01)</option>
                                        <option value="1">Feb (02)</option>
                                        <option value="2">Mar (03)</option>
                                        <option value="3">Apr (04)</option>
                                        <option value="4">May (05)</option>
                                        <option value="5">June (06)</option>
                                        <option value="6">July (07)</option>
                                        <option value="7">Aug (08)</option>
                                        <option value="8">Sep (09)</option>
                                        <option value="9">Oct (10)</option>
                                        <option value="10">Nov (11)</option>
                                        <option value="11">Dec (12)</option>
                                      </select>
                                    </div>
                                    <div class="col-xs-3">
                                      <select class="form-control" name="from-year">
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                      </select>
                                    </div>
                                  </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-xs-2">
                                        To
                                        </div>
                                    <div class="col-xs-3">
                                      <select class="form-control col-sm-2" name="to-day" id="to-day">
                                        <option selected disabled>Date</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                        <option value="6">6</option>
                                        <option value="7">7</option>
                                        <option value="8">8</option>
                                        <option value="9">9</option>
                                        <option value="10">10</option>
                                        <option value="11">11</option>
                                        <option value="12">12</option>
                                        <option value="13">13</option>
                                        <option value="14">14</option>
                                        <option value="15">15</option>
                                        <option value="16">16</option>
                                        <option value="17">17</option>
                                        <option value="18">18</option>
                                        <option value="19">19</option>
                                        <option value="20">20</option>
                                        <option value="21">21</option>
                                        <option value="22">22</option>
                                        <option value="23">23</option>
                                        <option value="24">24</option>
                                        <option value="25">25</option>
                                        <option value="26">26</option>
                                        <option value="27">27</option>
                                        <option value="28">28</option>
                                        <option value="29">29</option>
                                        <option value="30">30</option>
                                        <option value="31">31</option>
                                      </select>
                                    </div>
                                    <div class="col-xs-4">
                                      <select class="form-control col-sm-2" name="to-month" id="to-month">
                                        <option>Month</option>
                                        <option value="0">Jan (01)</option>
                                        <option value="1">Feb (02)</option>
                                        <option value="2">Mar (03)</option>
                                        <option value="3">Apr (04)</option>
                                        <option value="4">May (05)</option>
                                        <option value="5">June (06)</option>
                                        <option value="6">July (07)</option>
                                        <option value="7">Aug (08)</option>
                                        <option value="8">Sep (09)</option>
                                        <option value="9">Oct (10)</option>
                                        <option value="10">Nov (11)</option>
                                        <option value="11">Dec (12)</option>
                                      </select>
                                    </div>
                                    <div class="col-xs-3">
                                      <select class="form-control" name="to-year">
                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
                                        <option value="2017">2017</option>
                                        <option value="2018">2018</option>
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                      </select>
                                    </div>
                                  </div>
                                </div>
                                <div class="form-group">
                                    <textarea name="additional_message" class="form-control"  placeholder="Additional Message" rows="4"><%= user.getPreference() %></textarea>
                                </div>
                                <input type='submit' name='reserve' value='Reserve' class="btn btn-default" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>  
        </div>
    </div>
    <!-- reservation-information -->
</div>
<%@include file="footer.jsp" %>