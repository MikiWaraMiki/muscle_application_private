User.create(name:"sample1",email: 'admin@test.com', password: 'password')
User.create(name:"sample2",email: 'satou@test.com', password: 'password')
User.create(name:"sample3",email: 'suzuki@test.com', password: 'password')
User.create(name:"sample4",email: 'tanaka@test.com', password: 'password')
User.create(name:"sample5",email: 'test@test.com', password: 'password')
Todo.create(users_id:1, title:"sample1", weight:10, set_count:20, clear_plan:"2019-04-08",cleared: true)
Todo.create(users_id:1, title:"sample2", weight:10, set_count:20, clear_plan:"2019-04-08",cleared: true)
Todo.create(users_id:1, title:"sample1", weight:10, set_count:20, clear_plan:"2019-04-08",cleared: false)
Todo.create(users_id:1, title:"sample1", weight:10, set_count:20, clear_plan:"2019-04-09",cleared: true)
Todo.create(users_id:1, title:"sample2", weight:10, set_count:20, clear_plan:"2019-04-08",cleared: true)



