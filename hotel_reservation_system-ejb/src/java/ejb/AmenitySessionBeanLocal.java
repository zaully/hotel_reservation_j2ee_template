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
public interface AmenitySessionBeanLocal {

    List getAllAmenities(int count, int skip);

    int getTotalCount();

    Object getAmenityByAID(int aid);

    Boolean createAmenity(Object amenity);

    Boolean saveChange(Object amenity);

    void deleteAmenity(int aid);
    
}
