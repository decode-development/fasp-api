/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cc.altius.FASP.jwt;

import cc.altius.FASP.rest.controller.UserRestController;
import cc.altius.FASP.security.CustomUserDetailsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Order(1000)
public class JWTWebSecurityConfig {

    @Autowired
    private JwtUnAuthorizedResponseAuthenticationEntryPoint jwtUnAuthorizedResponseAuthenticationEntryPoint;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private JwtTokenAuthorizationOncePerRequestFilter jwtAuthenticationTokenFilter;

    @Value("${jwt.get.token.uri}")
    private String authenticationPath;
    @Value("${jwt.refresh.token.uri}")
    private String refreshPath;

    private final Logger logger = LoggerFactory.getLogger(UserRestController.class);

//    @Autowired
//    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
//        auth
//                .userDetailsService(customUserDetailsService)
//                .passwordEncoder(passwordEncoderBean());
//    }
    @Bean
    public PasswordEncoder passwordEncoderBean() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(customUserDetailsService);
        authProvider.setPasswordEncoder(passwordEncoderBean());

        return authProvider;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(csrf -> csrf.disable())
                .exceptionHandling(exception -> exception.authenticationEntryPoint(jwtUnAuthorizedResponseAuthenticationEntryPoint))
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authorizeHttpRequests(auth
                        -> auth
                        .requestMatchers(HttpMethod.POST, authenticationPath).permitAll()
                        .requestMatchers(HttpMethod.GET, refreshPath).permitAll()
                        .requestMatchers(HttpMethod.GET, "/").permitAll()
                        .requestMatchers("/actuator/**").permitAll()
                        .requestMatchers("/favicon.ico**").permitAll()
                        .requestMatchers("/actuator**").permitAll()
                        .requestMatchers("/actuator/info").permitAll()
                        .requestMatchers("/browser**").permitAll()
                        .requestMatchers("/file**").permitAll()
                        .requestMatchers("/file/**").permitAll()
                        //                .requestMatchers("/v2/api-docs", "/configuration/ui", "/swagger-resources", "/swagger-resources/configuration/security", "/swagger-ui.html**", "/swagger-resources/configuration/ui").permitAll()
                        .requestMatchers("/api/locales/*/**").permitAll()
                        .requestMatchers("/api/forgotPassword/**").permitAll()
                        .requestMatchers("/api/getForgotPasswordToken/**").permitAll()
                        .requestMatchers("/api/confirmForgotPasswordToken/**").permitAll()
                        .requestMatchers("/api/updatePassword/**").permitAll()
                        //                .requestMatchers("/api/user/**").permitAll()
                        .requestMatchers("/api/updateExpiredPassword/**").permitAll()
                        .requestMatchers("/exportSupplyPlan/**").permitAll()
                        .requestMatchers("/exportProgramData/**").permitAll()
                        .requestMatchers("/exportOrderData/**").permitAll()
                        .requestMatchers("/importShipmentData/**").permitAll()
                        .requestMatchers("/importProductCatalog/**").permitAll()
                        .requestMatchers("/api/sync/language/**").permitAll()
                        .requestMatchers("/exportShipmentLinkingData/**").permitAll()
                        .requestMatchers("/jira/syncJiraAccountIds/**").permitAll()
                        .requestMatchers("/api/processCommitRequest/**").permitAll()
                        .anyRequest().authenticated()
                );

        http.authenticationProvider(authenticationProvider());

        http.addFilterBefore(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

//    @Override
//    protected void configure(HttpSecurity httpSecurity) throws Exception {
//        httpSecurity
//                .csrf().disable()
//                .exceptionHandling().authenticationEntryPoint(jwtUnAuthorizedResponseAuthenticationEntryPoint).and()
//                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS).and()
//                .authorizeRequests()
//                //                .antMatchers("/actuator/info").permitAll()
//                //                .antMatchers("/api/healthArea/**").access("hasRole('ROLE_BF_UPDATE_REALM_MASTER')")
//                //                .antMatchers("/api/organisation/**").access("hasRole('ROLE_BF_UPDATE_REALM_MASTER')")
//                //                .antMatchers("/api/unit/**").access("hasRole('ROLE_BF_UPDATE_APPL_MASTER')")
//                //                .antMatchers(HttpMethod.POST, "/api/realm/**").access("hasAnyRole('ROLE_BF_UPDATE_APPL_MASTER')")
//                //                .antMatchers(HttpMethod.PUT, "/api/realm/**").access("hasAnyRole('ROLE_BF_UPDATE_APPL_MASTER', 'ROLE_BF_UPDATE_REALM_MASTER')")
//                //                .antMatchers("/api/realmCountry/**").access("hasRole('ROLE_BF_UPDATE_REALM_MASTER')")
//                .anyRequest().authenticated();
//
////    @EventListener
////    public void authSuccessEventListener(AuthenticationSuccessEvent authorizedEvent){
////        authorizedEvent.
////    }
////
////    @EventListener
////    public void authFailedEventListener(AbstractAuthenticationFailureEvent oAuth2AuthenticationFailureEvent){
////        
////    }
//    }
}
