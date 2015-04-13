/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.List;
import javax.ejb.Local;

/**
 *
 * @author vince
 */
@Local
public interface RoomTypeSessionBeanLocal {
    public List getAllRoomTypes();

    Object getRoomTypeDetails(int room_type_id);
    
    public List getAllRoomTypes(int count, int skip);
    
    public int getTotalCount();
    
    public Boolean createObject(Object obj);
    
    public Boolean saveChange(Object obj);
    
    public void deleteObject(int id);

    List getAmenities(int rid);

    Boolean saveAmenities(int rid, String[] amenitieIDs);
}
