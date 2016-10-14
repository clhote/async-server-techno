
var should = require('should');
var user = require('../src/user.js');

describe('my first test list', function() {

  it('should return caroline (get)', function(){
    user.get("caroline",function(done){
      done.should.equal("caroline");
    })
  })

  it('should not return caroline (get)', function(){
    user.get("test",function(res){
      res.should.be.not.equal("caroline");
    })
  })

  it('save : should return caroline', function(){
    user.save("caroline",function(res){
      res.should.equal("caroline");
    })
  })
  //it('should do smth else', function(done){...})
})
