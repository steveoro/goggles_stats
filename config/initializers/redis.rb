# Create a new local client instance for Redis:
#$redis = Redis::Namespace.new(
Redis.current = Redis::Namespace.new(
  "goggles_stats",
  redis: Redis.new(host: 'localhost', port: 6379)
)
