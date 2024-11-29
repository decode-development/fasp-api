package cc.altius.FASP.dao.unit;

import cc.altius.FASP.dao.impl.UserDaoImpl;
import cc.altius.FASP.exception.AccessControlFailedException;
import cc.altius.FASP.model.*;
import cc.altius.FASP.model.rowMapper.*;
import cc.altius.FASP.service.AclService;
import cc.altius.utils.DateUtils;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import java.util.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class UserDaoImplTest {

    @Mock
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Mock
    private AclService aclService;

    @Mock
    private CustomUserDetailsResultSetExtractorBasic customUserDetailsResultSetExtractor;

    @Mock
    private UserResultSetExtractor userResultSetExtractor;

    @Mock
    private RoleResultSetExtractor roleResultSetExtractor;

    @InjectMocks
    private UserDaoImpl userDaoImpl;

    @Test
    public void testGetCustomUserByUsername() {
        String username = "testUser";
        CustomUserDetails expectedUser = new CustomUserDetails();
        expectedUser.setUsername(username);
        Map<String, Object> params = new HashMap<>();
        params.put("username", username);
        when(namedParameterJdbcTemplate.query(anyString(), any(Map.class), any(CustomUserDetailsResultSetExtractorBasic.class))).thenReturn(expectedUser);
        CustomUserDetails actualUser = userDaoImpl.getCustomUserByUsername(username);
        assertNotNull(actualUser);
        assertEquals(expectedUser.getUsername(), actualUser.getUsername());
    }

    @Test
    public void testGetCustomUserByEmailId() {
        String emailId = "test@example.com";
        CustomUserDetails expectedUser = new CustomUserDetails();
        expectedUser.setEmailId(emailId);
        Map<String, Object> params = new HashMap<>();
        params.put("emailId", emailId);
        when(namedParameterJdbcTemplate.query(anyString(), any(Map.class), any(CustomUserDetailsResultSetExtractorBasic.class))).thenReturn(expectedUser);
        CustomUserDetails actualUser = userDaoImpl.getCustomUserByEmailId(emailId);
        assertNotNull(actualUser);
        assertEquals(expectedUser.getEmailId(), actualUser.getEmailId());
    }

    @Test
    public void testGetCustomUserByUserId() {
        int userId = 1;
        CustomUserDetails expectedUser = new CustomUserDetails();
        expectedUser.setUserId(userId);
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        when(namedParameterJdbcTemplate.query(anyString(), any(Map.class), any(CustomUserDetailsResultSetExtractorFull.class))).thenReturn(expectedUser);
        CustomUserDetails actualUser = userDaoImpl.getCustomUserByUserId(userId);
        assertNotNull(actualUser);
        assertEquals(expectedUser.getUserId(), actualUser.getUserId());
    }

    @Test
    public void testGetRoleById() {
        String roleId = "testRole";
        Role expectedRole = new Role();
        expectedRole.setRoleId(roleId);
        Map<String, Object> params = new HashMap<>();
        params.put("roleId", roleId);
        when(namedParameterJdbcTemplate.query(anyString(), any(Map.class), any(RoleResultSetExtractor.class))).thenReturn(expectedRole);
        Role actualRole = userDaoImpl.getRoleById(roleId);
        assertNotNull(actualRole);
        assertEquals(expectedRole.getRoleId(), actualRole.getRoleId());
    }

    @Test
    public void testAddNewUser() throws AccessControlFailedException {
        User user = new User();
        user.setRealm(new Realm(1));
        user.setLanguage(new Language(1));
        user.setUserAcls(List.of(new UserAcl()).toArray(new UserAcl[0]));
        CustomUserDetails curUser = new CustomUserDetails();
        int expectedUserId = 1;

        Map<String, Object> params = new HashMap<>();
        params.put("REALM_ID", user.getRealm().getRealmId());
        params.put("AGREEMENT_ACCEPTED", false);
        params.put("USERNAME", user.getUsername());
        params.put("PASSWORD", user.getPassword());
        params.put("EMAIL_ID", user.getEmailId());
        params.put("ORG_AND_COUNTRY", user.getOrgAndCountry());
        params.put("LANGUAGE_ID", user.getLanguage().getLanguageId());
        params.put("DEFAULT_MODULE_ID", 1);
        params.put("DEFAULT_THEME_ID", 1);
        params.put("SHOW_DECIMALS", true);
        params.put("ACTIVE", true);
        params.put("FAILED_ATTEMPTS", 0);
        params.put("EXPIRES_ON", DateUtils.getOffsetFromCurrentDateObject(DateUtils.EST, -1));
        params.put("SYNC_EXPIRES_ON", DateUtils.getOffsetFromCurrentDateObject(DateUtils.EST, -1));
        params.put("LAST_LOGIN_DATE", null);
        params.put("CREATED_BY", curUser.getUserId());
        params.put("CREATED_DATE", DateUtils.getCurrentDateString(DateUtils.EST, DateUtils.YMDHMS));
        params.put("LAST_MODIFIED_BY", curUser.getUserId());
        params.put("LAST_MODIFIED_DATE", DateUtils.getCurrentDateString(DateUtils.EST, DateUtils.YMDHMS));

        when(namedParameterJdbcTemplate.update(anyString(), any(Map.class))).thenReturn(1);
        when(namedParameterJdbcTemplate.queryForObject(anyString(), any(Map.class), eq(Integer.class))).thenReturn(expectedUserId);
        when(namedParameterJdbcTemplate.batchUpdate(anyString(), any(Map[].class))).thenReturn(new int[]{1});
        int actualUserId = userDaoImpl.addNewUser(user, curUser);
        assertEquals(expectedUserId, actualUserId);
    }

    @Test
    public void testGetUserList() {
        CustomUserDetails curUser = new CustomUserDetails();
        when(namedParameterJdbcTemplate.queryForObject(anyString(), anyMap(), eq(Boolean.class))).thenReturn(true);
        User user = new User();
        user.setUsername("user1");
        User user2 = new User();
        user2.setUsername("user2");
        List<User> mockUsers = Arrays.asList(user, user2);
        when(namedParameterJdbcTemplate.query(anyString(), anyMap(), any(UserListResultSetExtractor.class))).thenReturn(mockUsers);
        List<User> result = userDaoImpl.getUserList(curUser);
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    public void testGetUserDropDownList() {
        CustomUserDetails curUser = new CustomUserDetails();
        List<BasicUser> expectedUsers = new ArrayList<>();
        when(namedParameterJdbcTemplate.query(anyString(), any(Map.class), any(BasicUserRowMapper.class))).thenReturn(expectedUsers);
        List<BasicUser> actualUsers = userDaoImpl.getUserDropDownList(curUser);
        assertNotNull(actualUsers);
        assertEquals(expectedUsers, actualUsers);
    }

    @Test
    public void testGetUserListForRealm() {
        when(namedParameterJdbcTemplate.queryForObject(anyString(), anyMap(), eq(Boolean.class))).thenReturn(true);
        User user = new User();
        user.setUsername("user1");
        User user2 = new User();
        user2.setUsername("user2");
        List<User> mockUsers = Arrays.asList(user, user2);
        when(namedParameterJdbcTemplate.query(anyString(), anyMap(), any(UserListResultSetExtractor.class))).thenReturn(mockUsers);
        List<User> result = userDaoImpl.getUserList(new CustomUserDetails());
        assertNotNull(result);
        assertEquals(2, result.size());
    }

    @Test
    public void testGetBusinessFunctionsForUserId() {
        int userId = 1;
        List<String> expectedBusinessFunctions = new ArrayList<>();
        Map<String, Object> params = new HashMap<>();
        params.put("userId", userId);
        when(namedParameterJdbcTemplate.queryForList(anyString(), any(Map.class), eq(String.class))).thenReturn(expectedBusinessFunctions);
        List<String> actualBusinessFunctions = userDaoImpl.getBusinessFunctionsForUserId(userId);

        assertNotNull(actualBusinessFunctions);
        assertEquals(expectedBusinessFunctions, actualBusinessFunctions);
    }

    @Test
    public void testResetFailedAttemptsByUsername() {
        String username = "testUser";
        int expectedRowsAffected = 1;
        Map<String, Object> params = new HashMap<>();
        params.put("emailId", username);
        params.put("curDate", DateUtils.getCurrentDateString(DateUtils.EST, DateUtils.YMDHMS));

        when(namedParameterJdbcTemplate.update(anyString(), any(Map.class))).thenReturn(expectedRowsAffected);
        int actualRowsAffected = userDaoImpl.resetFailedAttemptsByUsername(username);
        assertEquals(expectedRowsAffected, actualRowsAffected);
    }

    @Test
    public void testUpdateFailedAttemptsByUserId() {
        String emailId = "test@example.com";
        int expectedRowsAffected = 1;
        Map<String, Object> params = new HashMap<>();
        params.put("emailId", emailId);
        when(namedParameterJdbcTemplate.update(anyString(), any(Map.class))).thenReturn(expectedRowsAffected);
        int actualRowsAffected = userDaoImpl.updateFailedAttemptsByUserId(emailId);
        assertEquals(expectedRowsAffected, actualRowsAffected);
    }
}