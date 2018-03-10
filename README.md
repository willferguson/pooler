# Waterpark

Process Pool library for starting and supervising pools of workers.

To start, add Waterpark.Owner to your supervision tree.
EG ```Supervisor.start_link(Waterpark.Owner, [])```

All functionality is exposed from the ```Waterpark``` helper module

Inspiration taken from learnyousomeerlang (http://learnyousomeerlang.com/building-applications-with-otp)
