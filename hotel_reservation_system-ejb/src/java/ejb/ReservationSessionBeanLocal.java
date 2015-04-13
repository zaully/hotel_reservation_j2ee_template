/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.Date;
import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author vince
 */
@Local
public interface ReservationSessionBeanLocal {
    
    public List getAllReservation(int count, int skip);
    
    public int getTotalCount();
    
    public Boolean createObject(Object obj);
    
    public Boolean saveChange(Object obj);
    
    public void deleteObject(int id);

    Object getReservation(int rid);

    List getAllReservation(int count, int skip, Date start, Date end);
    
    public int getTotalCount(Date start, Date end);

    Date getLastVisitByUserID(int uid);

    int getVisitsByUserID(int uid);
    
}
