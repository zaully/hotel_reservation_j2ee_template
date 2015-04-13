/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ejb;

import java.util.List;
import javax.ejb.Remote;

/**
 *
 * @author vince
 */
@Remote
public interface UserSessionBeanRemote {

    Boolean login(String email, String password);

    void logout();

    Boolean register(Object user);

    Boolean isLoggedIn();

    int getUserRoleID();

    Object getLoggedUser();

    Boolean saveChange(Object user);

    List getUsers(int count, int skip);

    int getUsersPageCount();

    Object getUserByUID(int uid);
    
}
