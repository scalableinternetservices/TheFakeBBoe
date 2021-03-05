counter = 1
num_users = 2000
with open("users.csv", "w") as f:
    f.write("username,email,password\n")
    while counter < num_users:
        f.write("EdgyM3m3L0rD" + str(counter) + ",userperson" + str(counter) + "@email.com,password\n") 
        counter += 1

counter = 1
with open("profiles.csv", "w") as f:
    f.write("name,age,location,occupation,bio,user_id\n")
    while counter < num_users:
        for i in range(3):
            f.write("namenamename,23,santa barbara,student,gib me A," + str(counter) + "\n") 
        counter += 1