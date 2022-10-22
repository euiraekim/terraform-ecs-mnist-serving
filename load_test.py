# locustfile.py
from locust import HttpUser, task, between, TaskSet


class UserBehavior(TaskSet):
    @task
    def home(self):
        with open('./test_images/img_9.jpg', 'rb') as image:
            self.client.post(
                "/predict",
                files={'file': image}
            )

class LocustUser(HttpUser):
    host = "http://my-alb-444662360.ap-northeast-2.elb.amazonaws.com"
    tasks = [UserBehavior]
    # wait_time = between(1, 4)