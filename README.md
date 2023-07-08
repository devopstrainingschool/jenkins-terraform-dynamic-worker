# add the key created to ssh-add
```
eval `ssh-agent -s`
```
```
ssh-add keyhere
```
### To verified
```
ssh-add -l
```

# Install jenkins 
https://github.com/devopstrainingschool/Jenkins-installation-steps

# Profile issue
```
aws iam list-instance-profiles-for-role --role-name jenkins-aws-role
```

```
aws iam remove-role-from-instance-profile --instance-profile-name profilenamehere --role-name jenkins-aws-role
```
