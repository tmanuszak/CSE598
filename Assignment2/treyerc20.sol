// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

contract TreyERC20 {
    mapping (address => uint256) private _balances;

    // For allowing other adresses to move funds of their account.
    mapping (address => mapping(address => uint256)) private _allowances;

    address private _creator;

    string private _name;
    string private _symbol;
    uint256 private _totalSupply;

    constructor (string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _creator = msg.sender;
        _totalSupply = 0;
    }

    // TASK 1
    function name() public view returns (string memory) {
        return _name;
    }

    // TASK 2
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // TASK 3
    function decimals() public view returns (uint8) {
        return 0;
    }

    // TASK 4
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    // TASK 5
    function transfer(address _to, uint256 _value) public returns (bool success) {
        address owner = msg.sender;

        if (_balances[owner] >= _value) {
            _balances[owner] -= _value;
            _balances[_to] += _value;
            emit Transfer(owner, _to, _value);

            return true;
        } 
        
        return false;
    }

    // In case I need to mint to certain addresses
    function mint(address _to, uint256 _value) public returns (bool success) {
        require(msg.sender == _creator, "Only the contract creator can mint these tokens.");
        _balances[_to] += _value;
        _totalSupply += _value;

        return true;
    }

    // TASK 6
    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }

    // TASK 7
    function approve(address _spender, uint256 _value) public returns (bool success) {
        address owner = msg.sender;
        _allowances[owner][_spender] = _value;
        emit Approval(owner, _spender, _value);

        return true;
    }

    // TASK 8
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return _allowances[_owner][_spender];
    }

    // TASK 9
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (_balances[_from] >= _value && _allowances[_from][_to] <= _value) {
            _balances[_from] -= _value;
            _balances[_to] += _value;
            _allowances[_from][_to] -= _value;
            emit Transfer(_from, _to, _value);

            return true;
        }

        return false;
    }

    // TASK 10
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    // TASK 11
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
