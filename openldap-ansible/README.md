# Тестовое задание Ansible
Написать Ansible скрипт реализующий следующее:
1. на ОС ubuntu LTS установить openldap сервер
2. установить в ldap пароль администратора
3. установить в ldap domain и organization
4. добавить 2 пользователя в ldap
6. добавить 2 группы в ldap

# Требования
- Ubuntu 22.04.1 LTS
- Python 3.10.6
- Ansible Core v2.14.2

# Подготовка
В файле ./group_vars/ldapserver заданы значения, используемые на тестовой инфраструктуре. В рамках тестового задания не стал затирать эти данные.
```sh
server_domain_name: srv.home.loc
server_base_dn: dc=home,dc=loc
```

В файле ./group_vars/ldapserver_secret задан пароль администратора. В рамках тестового задания не стал затирать эти данные.
```sh
ldap_admin_pw: password
```