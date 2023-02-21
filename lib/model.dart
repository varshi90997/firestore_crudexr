class user
{
  String? key,name,age;
  user(this.key,this.name,this.age);
  static user fromjson(Map m,String key)
  {
    return user(key,m['name'],m['age']);
  }
}