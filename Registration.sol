pragma solidity ^0.4.0;

contract register {
    struct reg {
        string first_name;
        string last_name;
        string email;
        string username;
        string phone_number;
        string password;
    }
    reg r; 
    uint i;
    
    function store(string _first_name, string _last_name, string _email, string _username, string _phone_number, string _password) public {
        r = reg(_first_name,_last_name,_email,_username,_phone_number,_password);
    }
    
    function get() public view returns (string) {
      return r.first_name;
    }
}
