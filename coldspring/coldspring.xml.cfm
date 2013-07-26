<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">

<beans default-autowire="byName">
	<bean id="MeldGoogleSitemapsManager" class="[plugin]com.meldsolutions.MeldGoogleSitemaps.application.MeldGoogleSitemapsManager">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>

		<property name="framework">
			<ref bean="framework" />
		</property>
	</bean>

	<bean id="mmResourceBundle" class="[plugin]com.meldsolutions.utility.mmResourceBundle.mmResourceBundle">
		<constructor-arg name="applicationKey"><value>${applicationKey}</value></constructor-arg>
		<constructor-arg name="pluginFileRoot"><value>${pluginFileRoot}</value></constructor-arg>
		<constructor-arg name="rblocale"><value>${rblocale}</value></constructor-arg>
	</bean>

	<bean id="framework" class="[plugin]Application">
	</bean>
</beans>