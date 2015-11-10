# Create a new local client instance for Redis:

# Redis support currently dropped from Master branch.
# (Edit Gemfile accordingly.)
if defined?(Redis) && defined?(Redis::Namespace)
  Redis.current = Redis::Namespace.new(
    "goggles_stats",
    redis: Redis.new(host: 'localhost', port: 6379)
  )
end
