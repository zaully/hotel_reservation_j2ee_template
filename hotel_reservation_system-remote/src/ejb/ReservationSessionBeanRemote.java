/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.Date;
import java.util.List;
import javax.ejb.Remote;

/**
 *
 * @author vince
 */
@Remote
public interface ReservationSessionBeanRemote {
    
    public List getAllReservation(int count, int skip);
    
    public int getTotalCount();
    
    public Boolean createObject(Object obj);
    
    public Boolean saveChange(Object obj);
    
    public void deleteObject(int id);

    Object getReservation(int rid);

    List getAllReservation(int count, int skip, Date start, Date end);
    
    List getAllReservation(int uid, int rid, int count, int skip, Date start, Date end);
    
    public int getTotalCount(Date start, Date end);

    Date getLastVisitByUserID(int uid);

    int getVisitsByUserID(int uid);

    Boolean reserve(int rid, int uid, Date from, Date to, int quantity, String additional_message);

    Boolean saveReservation(int res, Date from, Date to, int quantity, String additional_message);
    
}
