#ifndef __ASSERT_H__
#define __ASSERT_H__
int abort(const char *, int);

/* assert: If the cond is false, then the sreen will break and quit*/
#define assert(cond) \
	((cond) ? (0) : (abort(__FILE__, __LINE__)))

#endif
