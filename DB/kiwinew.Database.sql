/****** Object:  Database [kiwinew]    Script Date: 01-04-2025 23:02:29 ******/
CREATE DATABASE [kiwinew]  (EDITION = 'Standard', SERVICE_OBJECTIVE = 'S0', MAXSIZE = 250 GB) WITH CATALOG_COLLATION = SQL_Latin1_General_CP1_CI_AS, LEDGER = OFF;
GO
ALTER DATABASE [kiwinew] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [kiwinew] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [kiwinew] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [kiwinew] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [kiwinew] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [kiwinew] SET ARITHABORT OFF 
GO
ALTER DATABASE [kiwinew] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [kiwinew] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [kiwinew] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [kiwinew] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [kiwinew] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [kiwinew] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [kiwinew] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [kiwinew] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [kiwinew] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [kiwinew] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [kiwinew] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [kiwinew] SET  MULTI_USER 
GO
ALTER DATABASE [kiwinew] SET ENCRYPTION ON
GO
ALTER DATABASE [kiwinew] SET QUERY_STORE = ON
GO
ALTER DATABASE [kiwinew] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
ALTER DATABASE [kiwinew] SET  READ_WRITE 
GO
